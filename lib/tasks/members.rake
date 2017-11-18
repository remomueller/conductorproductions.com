# frozen_string_literal: true

namespace :members do
  desc "Initialize nicknames"
  task nicknames: :environment do
    [["Noah Lydiard", "Noah"], ["Vladimir Minuty", "Vladimir"], ["Christian Williams", "The Grand Optimist"], ["Lin Oeding", "Lin"], ["Lisa Mueller", "Mizz Moore"], ["Jenn Sargent", "Sargent"], ["Scott MacKinnon", "Scott"], ["Tone Evans", "Tone"]].each do |name, nickname|
      member = Member.find_by(name: name)
      member.update(nickname: nickname) if member
    end
  end
end
