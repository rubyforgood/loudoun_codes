module Support
  module Docker
    module Ruby
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
        <<~'GOODENTRYFILE'
        ARGF.each do |line|
          puts "#{line[1..-1].chomp}#{line[0...1]}ay"
        end
        GOODENTRYFILE
      end

      def bad_entry_file
        <<~'BADENTRYFILE'
        ARGF.each do |line|
          puts "a#{line[1..-1].chomp}#{line[0...1]}ay"
        end
        BADENTRYFILE
      end
    end
  end
end
