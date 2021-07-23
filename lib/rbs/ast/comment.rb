module RBS
  module AST
    class Comment
      attr_reader :location

      def initialize(string:, location:)
        @string = [string]
        @location = location
      end

      def string
        @string.join
      end

      def ==(other)
        other.is_a?(Comment) && other.string == string
      end

      alias eql? ==

      def hash
        self.class.hash ^ @string.hash
      end

      def to_json(state = _ = nil)
        { string: string, location: location }.to_json(state)
      end

      def concat(string:, location: nil, range: nil)
        @string << string

        if loc = @location
          if range
            loc.append_range range
          else
            loc << location
          end
        else
          raise
        end

        self
      end
    end
  end
end
