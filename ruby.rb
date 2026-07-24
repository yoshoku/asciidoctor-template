require 'asciidoctor/extensions'

# This extension adds a custom inline macro 'rb' to Asciidoctor for rendering furigana (ruby text).
# Usage in Asciidoctor document:
#   rb::漢字[かんじ, Kanji]
#
# This will render as:
#   <ruby>漢字<rp>（</rp><rt>かんじ</rt><rp>）</rp></ruby> (Kanji)
class FuriganaRubyMacro < Asciidoctor::Extensions::InlineMacroProcessor
  use_dsl

  named :rb

  def process(parent, target, attrs)
    base_text = target.delete_prefix(':')
    ruby_text = attrs[1]

    return base_text.to_s if ruby_text.nil? || ruby_text.empty?

    backend = backend(parent)
    parentheses_text = attrs.values[1...].join(', ') if attrs.size > 1

    unless parentheses_text.nil?
      parentheses_text = case backend
                         when 'html5', 'epub3', 'docbook5'
                           " (#{parentheses_text}) "
                         else
                           ", #{parentheses_text}"
                         end
    end

    case backend
    when 'html5'
      "<ruby>#{base_text}<rp> (</rp><rt>#{ruby_text}</rt><rp>) </rp></ruby>#{parentheses_text}"
    when 'epub3'
      "<ruby>#{base_text}<rt>#{ruby_text}</rt></ruby>#{parentheses_text}"
    when 'docbook5'
      "<phrase role=\"ruby\"><phrase role=\"rb\">#{base_text}</phrase><phrase role=\"rt\">#{ruby_text}</phrase></phrase>#{parentheses_text}"
    else
      "#{base_text} (#{ruby_text}#{parentheses_text}) "
    end
  end

  private

  def backend(parent)
    document = parent.respond_to?(:document) ? parent.document : nil
    document.respond_to?(:backend) ? document.backend : nil
  end
end

Asciidoctor::Extensions.register do
  inline_macro FuriganaRubyMacro
end
