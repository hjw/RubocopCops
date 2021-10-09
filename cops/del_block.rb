# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      # This cop checks for block comments
      #
      # @example
      #
      #   # bad - there are blocks of commented out code
      #   some_method
      #   =begin
      #    one empty line
      #    two empty lines
      #   some_method
      #   =end
      #
      #   # good
      #   <poof, it's all gone>
      #
      class DelBlock < Base
        include RangeHelp
        extend AutoCorrector

        MSG = 'get rid of commented code'
        BEGIN_LENGTH = "=begin\n".length
        END_LENGTH = "\n=end".length
        #LINE_OFFSET = 2

        def on_new_investigation
          processed_source.comments.each do |comment|
            next unless comment.document?

            add_offense(comment) do |corrector|
              eq_begin, eq_end, contents = parts(comment)

              corrector.remove(eq_begin)
              corrector.remove(contents)
              # unless contents.length.zero?
              #   corrector.replace( # currently adds a hash instead of deleting
              #                     contents,
              #                     contents.source.gsub(/\A/, '# ').gsub(/\n\n/, "\n#\n").gsub(/\n(?=[^#])/, "\n# ")
              #                    )
              # end
              corrector.remove(eq_end)
            end
          end
        end
        private

        def parts(comment)
          expr = comment.loc.expression
          eq_begin = expr.resize(BEGIN_LENGTH)
          eq_end = eq_end_part(comment, expr)
          contents = range_between(eq_begin.end_pos, eq_end.begin_pos)
          [eq_begin, eq_end, contents]
        end

        def eq_end_part(comment, expr)
          if comment.text.chomp == comment.text
            range_between(expr.end_pos - END_LENGTH - 1, expr.end_pos - 2)
          else
            range_between(expr.end_pos - END_LENGTH, expr.end_pos)
          end
        end
      end
    end
  end
end
