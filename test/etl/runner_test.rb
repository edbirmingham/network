require 'test_helper'
Dir[File.join(Rails.root, "/app/analytics/**/*.rb")].each do |file|
  require file
end

class ETLRunnerTest < ActiveSupport::TestCase
    def setup
        @etl_classes = [
            Etl::Dimensions::Date,
            Etl::Dimensions::Event,
            Etl::Dimensions::Grade,
            Etl::Dimensions::Member,
            Etl::Dimensions::Role,
            Etl::Facts::Programming,
            Etl::Facts::Participation
            ]
    end

    test 'Runner runs all the dimensions and facts' do
        nested_expectations(@etl_classes, :run) do
            Etl::Runner.run
        end
    end

    test 'All ETL classes are being tested' do
        dimensions = Etl::Dimensions.constants.map{ |c| Etl::Dimensions.const_get(c) }
        facts = Etl::Facts.constants.map{ |c| Etl::Facts.const_get(c) }
        assert_equal @etl_classes.sort_by(&:to_s), (dimensions + facts).sort_by(&:to_s)
    end

    private

    # In order to assert expectations on all the ETL objects with minitest, the
    # the run method must be stubbed with expectations in a nested hierarchy of
    # blocks.  That is how minitest stubbing works.
    #
    # Example:
    #   FooDimension.stub(:run) do
    #     BarDimension.stub(:run) do
    #       BazFact.stub(:run) do
    #         # run the ETL process.
    #       end
    #     end
    #   end
    #
    # This is a problem as the number of ETL facts and dimensions gets large
    # because the level of nesting will be very deep.  To make the expectations
    # work with any number of facts and dimensions, the #nested_expectations
    # method uses recursion to accomplish the nesting.
    def nested_expectations(klasses, method, &block)
        # If there are no more classes then execute the block.
        if klasses.empty?
            block.call
        # Otherwise, nest a new expectation.
        else
            # Set up expectation for the class method.
            mock = MiniTest::Mock.new
            mock.expect(:call, "Method ##{method} is not called for #{klasses.first}.")

            # Stub the method.
            klasses.first.stub(method, mock) do
                # Recursively set up the next expectation.
                nested_expectations(klasses[1..-1], method, &block)
            end

            # Verify that the stubbed method was called as expected.
            mock.verify
        end
    end
end