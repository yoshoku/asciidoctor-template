require 'bundler/setup'
require 'asciidoctor'
require 'asciidoctor-pdf'
require 'asciidoctor-mathematical'

require_relative 'trail'
require_relative 'ruby'

namespace :doc do
  task :html do
    Asciidoctor.convert_file(
      'src/index.adoc',
      to_file: 'public/index.html',
      backend: 'html5',
      safe: :unsafe
    )
  end
  task :pdf do
    Asciidoctor.convert_file(
      'src/index.adoc',
      to_file: 'public/index.pdf',
      backend: 'pdf',
      safe: :unsafe,
      attributes: {
        'mathematical-format' => 'svg'
      }
    )
  end
end
