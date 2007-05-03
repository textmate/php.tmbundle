#!/usr/bin/env ruby -wKU

# Extract function summaries from sources of PHP and its extensions
# 
# Example of block looked in .c, .cpp, .h and .ec files
# 
# /* {{{ proto string zend_version(void)
#   Get the version of the Zend Engine */
# 

require 'rubygems'
require 'builder'

path = ARGV.join('')
parsefiles = Dir[path + '**/*.{cpp,c,h,ec}']

unless parsefiles
  puts "No files found"
  exit
end

# These are language constructs rather than functions, so don't appear in the generated list
ConstructFunctions = %w[eval echo empty isset unset print list array]

# =======================
# = Source file parsing =
# =======================

# "\n\n/* {{{ proto string zend_version(void)\n   Get the version of the Zend Engine */"
proto_regex  = /^\s*?    # Start of the line
                 \/\*    # Start of the comment
                 \s+?   
                 \{{3}   # 3 Braces
                 \s+?
                 proto
                 \s+?
                 (\S+?)?  # Type
                 \s+?
                 (.+?)         # Function name
                 $             # End of the prototype line
                 (.+?)         # Function description
                \*\/      # End of the comment
              /msx
alias_regex  = /PHP_FALIAS\((\w+),\s*(\w+)/

functions = {}
aliases = {}
sections = {}
classes = []

# prototype blocks
parsefiles.sort.each_with_index do |file, key|
  file_contents = File.read(file)
  if file_contents.match(proto_regex)
    section = file.match(/^.+\/(?:zend_)?(.+)\..+$/).captures.first

    file_contents.gsub(proto_regex) do |proto|
      ret, rest, desc = $1, $2, $3
      next unless rest[/(?:(\S+?)::)?(\w+)\s*\(/]
      klass, name = $1, $2
      if klass
        # Class method
        # Ignore the method but add class name to a list
        classes << klass
        next
      end
      desc = desc.strip.gsub(/\s+?/ms, ' ')
      functions[name] = {:type => section, :return => ret, :description => desc, :prototype => ret + ' ' + rest}
      sections[section] ||= []
      sections[section] << name
    end
  end
  if file_contents.match(alias_regex)
    file_contents.gsub(alias_regex) do
      aliases[$1] = $2
    end
  end
end

aliases.each_pair do |func_alias, func|
  next unless functions[func]
  functions[func_alias] = functions[func].dup
  sections[functions[func][:type]] << func_alias
end

classes.uniq!

# =======================
# = Completions writing =
# =======================

completions = classes + functions.keys
completions.sort!

xml = Builder::XmlMarkup.new(:indent => 2, :target => File.open('../../Preferences/Completions.tmPreferences', 'w'))
xml.instruct!
xml.declare! :DOCTYPE, :plist, :public, "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"
xml.plist :version => '1.0' do
  xml.dict do
    xml.key 'name'
    xml.string 'Completions'
    xml.key 'scope'
    xml.string 'source.php'
    xml.key 'settings'
    xml.dict do
      xml.key 'completions'
      xml.array do
        completions.each do |function_name|
          xml.string function_name
        end
      end
    end
    xml.key 'uuid'
    xml.string '2543E52B-D5CF-4BBE-B792-51F1574EA05F'
  end
end

# ==================
# = Syntax writing =
# ==================
#  process_list
#  Created by Allan Odgaard on 2005-11-28.
#  http://macromates.com/svn/Bundles/trunk/Bundles/Objective-C.tmbundle/Support/list_to_regexp.rb
#
#  Read list and output a compact regexp
#  which will match any of the elements in the list
#  Modified by Ciarån Walsh to accept a plain string array
def process_list(list)
  buckets = { }
  optional = false

  list.map! { |term| term.unpack('C*') }

  list.each do |str|
    if str.empty? then
      optional = true
    else
      ch = str.shift
      buckets[ch] = (buckets[ch] or []).push(str)
    end
  end

  unless buckets.empty? then
    ptrns = buckets.collect do |key, value|
      [key].pack('C') + process_list(value.map{|item| item.pack('C*') }).to_s
    end

    if optional == true then
      "(" + ptrns.join("|") + ")?"
    elsif ptrns.length > 1 then
      "(" + ptrns.join("|") + ")"
    else
      ptrns
    end
  end
end

def print_pattern(name, list, require_parens = true)
  return unless list = process_list(list)
  puts <<-END
{	name = '#{ name }';
match = '(?i)\\b#{ list }\\b#{"(?=\\s*\\()" if require_parens}';
},
  END
end

print_pattern('support.function.construct.php', ConstructFunctions, false)
sections.sort.each do |(section, funcs)|
  print_pattern('support.function.' + section + '.php', funcs)
end
print_pattern('support.class.builtin.php', classes)

# =========================
# = Functions.txt writing =
# =========================
File.open('../functions.txt', 'w') do |file|
  functions.sort.each do |function, data|
    file << function + '%' + data[:prototype] + '%' + data[:description] + "\n"
  end
end