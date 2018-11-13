class Etl::Runner
    def self.run
        Etl::Dimensions::Role.run
        Etl::Dimensions::Member.run
        Etl::Dimensions::Grade.run
        Etl::Dimensions::Event.run
        Etl::Dimensions::Date.run
        Etl::Facts::Participation.run
        Etl::Facts::Programming.run
    end
end