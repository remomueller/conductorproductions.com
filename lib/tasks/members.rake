# frozen_string_literal: true

namespace :members do
  desc "Initialize nicknames"
  task nicknames: :environment do
    [
      ["Noah Lydiard", "Noah"],
      ["Vladimir Minuty", "Vladimir"],
      ["Christian Williams", "The Grand Optimist"],
      ["Lin Oeding", "Lin"],
      ["Jenn Sargent", "Sargent"],
      ["Lisa Mueller", "Mizz Moore"],
      ["Scott MacKinnon", "Scott"],
      ["Tone Evans", "Tone"]
    ].each_with_index do |(name, nickname), index|
      member = Member.find_by(name: name)
      member.update(nickname: nickname, position: index + 1) if member
    end
  end
end
