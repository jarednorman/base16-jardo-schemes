#!/usr/bin/env ruby

require 'pry'
require 'erb'
require 'color_math'

TEMPLATE = <<~TEMPLATE.freeze
  scheme: "Jardo Brighter"
  author: "Jared Norman (https://jardo.dev)"
  base00: "<%= base00 %>"
  base01: "<%= base01 %>"
  base02: "<%= base02 %>"
  base03: "<%= base03 %>"
  base04: "<%= base04 %>"
  base05: "<%= base05 %>"
  base06: "<%= base06 %>"
  base07: "<%= base07 %>"
  base08: "<%= base08 %>"
  base09: "<%= base09 %>"
  base0A: "<%= base0A %>"
  base0B: "<%= base0B %>"
  base0C: "<%= base0C %>"
  base0D: "<%= base0D %>"
  base0E: "<%= base0E %>"
  base0F: "<%= base0F %>"
TEMPLATE

OUTPUT_FILENAME = "jardo-brighter.yaml".freeze

Theme = Struct.new(
  :base00, # Black           - Default Background                                                
  :base01, # Darker Grey     - Lighter Background (Used for status bars, line number and folding marks)
  :base02, # Dark Grey       - Selection Background
  :base03, # Less Dark Grey  - Comments, Invisibles, Line Highlighting
  :base04, # Less Light Grey - Dark Foreground (Used for status bars)
  :base05, # Light Grey      - Default Foreground, Caret, Delimiters, Operators
  :base06, # Lighter Grey    - Light Foreground (Not often used)
  :base07, # White           - Light Background (Not often used)
  :base08, # Red             - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
  :base09, # Orange          - Integers, Boolean, Constants, XML Attributes, Markup Link Url
  :base0A, # Yellow          - Classes, Markup Bold, Search Text Background
  :base0B, # Green           - Strings, Inherited Class, Markup Code, Diff Inserted
  :base0C, # Cyan            - Support, Regular Expressions, Escape Characters, Markup Quotes
  :base0D, # Blue            - Functions, Methods, Attribute IDs, Headings
  :base0E, # Purple          - Keywords, Storage, Selector, Markup Italic, Diff Changed
  :base0F, # Brown           - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
  keyword_init: true
) do
  def render
    ERB.new(TEMPLATE).result(binding)
  end
end

class Color
  def initialize(h, s, l)
    @color = ColorMath.from_hsl(h, s, l)
  end

  def to_hex
    @color.to_hex.gsub("#", "")
  end
end

binding.pry

puts ColorMath.from_hsl(0, 33, 55).to_hex

result = Theme.new(
  base00: Color.new(0, 0, 0).to_hex,
  base01: "282828",
  base02: "383838",
  base03: "585858",
  base04: "b8b8b8",
  base05: "d8d8d8",
  base06: "e8e8e8",
  base07: "ffffff",
  base08: "ab4642",
  base09: "dc9656",
  base0A: "f7ca88",
  base0B: "a1b56c",
  base0C: "86c1b9",
  base0D: "7cafc2",
  base0E: "ba8baf",
  base0F: "a16946",
).render

puts result
# File.write(OUTPUT_FILENAME, result)
