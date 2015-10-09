# Require core library
require 'middleman-core'

::Middleman::Extensions.register(:katex) do
  require 'middleman-katex/middleman_extension'
  ::Middleman::Katex::Katex
end
