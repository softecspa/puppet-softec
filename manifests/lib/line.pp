# == define softec::lib::line
#
# Remove or append a certain line in the specific file
#
# Taken from https://reductivelabs.com/trac/puppet/wiki/SimpleTextRecipes
#
# === Params
#
# [*file*]
#   File to be managed (mandatory)
#
# [*line*]
#   Line in the file to be managed (mandatory)
#
# [*ensure*]
#   Decide if line should or should not exists in file (default: present)
#
# === Examples
#
#  softec::lib::line { 'set value in /path/to/file':
#    ensure          => present,
#    file            => '/path/to/file',
#    line            => 'key=value',
#  }
#
#  This ensure that in file /path/to/file there is a line that 
#  contains exactly key=value
#
define softec::lib::line($file, $line, $ensure = 'present') {
    case $ensure {
        default : { err ( "unknown ensure value ${ensure}" ) }
        present: {
            exec { "/bin/echo '${line}' >> '${file}'":
                unless => "/bin/grep -Fx '${line}' '${file}'"
            }
        }
        absent: {
            exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
               onlyif => "/bin/egrep -qFx '${line}' '${file}'"
            }
        }
    }
}
