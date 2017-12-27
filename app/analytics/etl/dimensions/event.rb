class Etl::Dimensions::Event
    def self.run
        NetworkEvent.all.each do |event|
            attributes = {
                network_event_id: event.id,
                location: event.location.try(:name),
                program: event.program.try(:name)
            }

            if EventDimension.where(network_event_id: attributes[:network_event_id]).exists?
                EventDimension.
                    where(network_event_id: attributes[:network_event_id]).
                    update_all(attributes)
            else
                EventDimension.create(attributes)
            end
        end
    end
end