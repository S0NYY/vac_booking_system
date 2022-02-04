module Web
  module Steps
    # ...
    class Step0PrevService
      include Interactor

      before do
        context.current_step = 0
        context.first_step = true
      end

      def call
        context.record = nil
      end
    end
  end
end
