class Etl::Dimensions::Member
    def self.run
        Member.all.each do |member|
            attributes = {
                member_id: member.id,
                identity: member.identity.try(:name),
                child_in_school_system: false,
                graduating_class: member.graduating_class.try(:year),
                school: member.school.try(:name),
                city: member.city,
                state: member.state,
                zip: member.zip_code,
                high_school_gpa: member.high_school_gpa,
                act_score: member.act_score,
                sex: member.sex,
                race: member.race
            }

            if MemberDimension.where(member_id: attributes[:member_id]).exists?
                MemberDimension.
                    where(member_id: attributes[:member_id]).
                    update_all(attributes)
            else
                MemberDimension.create(attributes)
            end
        end
    end
end