require "#{ENV["TM_SUPPORT_PATH"]}/lib/scriptmate"

class PhpScript < UserScript
  def lang; "Php" end
  # Disable display_errors so that errors are printed to stderr only
  def args; ['-d display_errors=off'] end
  def filter_cmd(cmd)
    # PHP doesn't understand - to mean stdin :(
    cmd[cmd.size - 1] = '--' if cmd.last == '-'
    cmd
  end
  def executable; @hashbang || ENV['TM_PHP'] || 'php' end
  def version_string
    php_path = %x{ #{ENV['TM_RUBY'] || 'ruby'} -e 'require "rbconfig"; print Config::CONFIG["bindir"] + "/" + Config::CONFIG["ruby_install_name"]'}
    res = %x{ #{executable} -v | head -n1 | cut -d" " -f 1-3 }
    res + " (#{php_path})"
  end
end

# Inherit to change the title
class PhpMate < ScriptMate
  def filter_stderr(str)
    # strings from stderr are passwed through this method before printing
    '<span style="color: red">' + 
    str.gsub(/in (.+?) on line (\d+)$/) {
      'in <a href="txmt://open?' + (ENV.has_key?('TM_FILEPATH') ? "url=file://#{$1}&amp;" : '') + 'line=' + $2 + '"> ' + $1 + ' on line ' + $2 + '</a>'
    } +
    '</span>'
  end
end

script = PhpScript.new(STDIN.read)
PhpMate.new(script).emit_html
