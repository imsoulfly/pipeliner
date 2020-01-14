RSpec.describe Pipeliner::Pipeline do
  context "normal behavior" do
    class Test1
      include Pipeliner::Pipeline

      pipeline :do_something_1,
               :do_something_2

      def do_something_1(context)
        context.done = true
      end

      def do_something_2(context)
        context.processed = context.wow
      end
    end

    it "expect pipeline to be processed" do
      context = Test1.call(wow: "run")
      expect(context.done).to eql(true)
      expect(context.wow).to eql("run")
      expect(context.processed).to eql("run")
      expect(context.success?).to eql(true)
    end
  end

  context "fail early behavior" do
    class Test2
      include Pipeliner::Pipeline

      pipeline :do_something_1,
               :do_something_2

      def do_something_1(context)
        # Something went wrong
        fail!("Did uppsie!")
      end

      def do_something_2(context)
        context.done = true
      end
    end

    it "expect pipeline to exit early" do
      context = Test2.call()
      expect(context.failure?).to eql(true)
      expect(context.error).to eql("Did uppsie!")
      expect(context.done).to eql(nil)
    end
  end
end
