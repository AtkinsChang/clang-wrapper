#!/usr/bin/env ruby

flags = [ "-Wno-invalid-pp-token", "-Wno-unicode", "-Wno-trigraphs" ]

if (['-E','-undef','-traditional'] - ARGV).empty?
   ARGV.each_with_index { |this, index| ARGV[index+1] = 'assembler-with-cpp' if this == '-x' && ARGV[index+1] == 'c' } 
end

system "clang", *flags, *ARGV
