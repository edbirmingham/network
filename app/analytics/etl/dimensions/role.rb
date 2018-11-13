class Etl::Dimensions::Role
    def self.run
        Participation.select(:level).group(:level).each do |participation|
            attributes = { name: participation.level }

            unless RoleDimension.where(name: attributes[:name]).exists?
                RoleDimension.create(attributes)
            end
        end
    end
end