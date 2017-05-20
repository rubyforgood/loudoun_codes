module Support
  module Docker
    module Python
      def in_file
        <<~INFILE
        meow
        meow
        INFILE
      end

      def out_file
        <<~OUTFILE
        eowmay
        eowmay
        OUTFILE
      end

      def good_entry_file
<<-'GOODENTRYFILE'
import sys
for line in sys.stdin.readlines():    
  print(line[1:].rstrip('\n') + line[0:1] + "ay")

GOODENTRYFILE
      end

      def bad_entry_file
<<-'BADENTRYFILE'
import sys
for line in sys.stdin.readlines():    
  print(line[1:].rstrip('\n') + line[0:1] + "ape")

BADENTRYFILE
      end
    end
  end
end
