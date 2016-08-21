# frozen_string_literal: true

namespace :videos do
  desc "Populate Initial Videos on WORK and DRTV pages"
  task populate: :environment do
    user = User.where(system_admin: true).first
    work_videos.each_with_index do |(photo, vimeo_number), position|
      create_video('work', photo, vimeo_number, position, user)
    end
    drtv_videos.each_with_index do |(photo, vimeo_number), position|
      create_video('drtv', photo, vimeo_number, position, user)
    end
  end

  def create_video(page, photo_name, vimeo_number, position, user)
    puts "#{page.upcase}: Creating Video ##{vimeo_number} #{photo_name}"
    photo = File.open(Rails.root.join("app", "assets", "images", "videos", page, photo_name))
    user.videos.create(
      page: page,
      vimeo_number: vimeo_number,
      photo: photo,
      position: position)
  end

  def work_videos
   [
      ["work-brother-thumb.png", "111656553"],
      ["work-netflix-thumb.png", "124955438"],
      ["work-putnam-beach-thumb.png", "124955435"],
      ["work-nike-thumb.png", "124955437"],
      ["work-reebok-thumb.png", "98734404"],
      ["work-toyota-tacoma-thumb.png", "105769621"],
      ["work-putnam-car-thumb.png", "124955436"],
      ["work-putnam-steele-thumb.png", "124955190"],
      ["work-putnam-ligety-thumb.png", "117310971"],
      ["work-tiger-home-inspection-thumb.png", "124955183"],
      ["work-toyota-chcs-thumb.png", "125048207"],
      ["work-falcon-thumb.png", "105791712"],
      ["work-party-lite-thumb.png", "101955253"],
      ["work-rockport-thumb.png", "125082260"],
      ["work-irobot-thumb.png", "50614258"],
      ["work-toyota-5-state-thumb.png", "107934478"],
      ["work-baymen-thumb.png", "105769141"],
      ["work-1800flowers-thumb.png", "48365590"],
      ["work-summer-infant-thumb.png", "79689801"],
      ["work-toyota-facebook-thumb.png", "47943063"],
      ["work-home-goods-thumb.png", "48446906"]
    ]
  end

  def drtv_videos
    [
      ["drtv-brother-thumb.png", "111740592"],
      ["drtv-1800flowers-thumb.png", "48365590"],
      ["drtv-dragon-thumb.png", "48810429"],
      ["drtv-hookits-thumb.png", "124955184"],
      ["drtv-popup-lantern-thumb.png", "124955187"],
      ["drtv-dreamers-thumb.png", "124955189"],
      ["drtv-goji-host-thumb.png", "111016727"],
      ["drtv-citizens-disability-thumb.png", "67747842"],
      ["drtv-flexshopper-test-thumb.png", "111673757"],
      ["drtv-mae-thumb.png", "125151198"],
      ["drtv-tiger-home-inspection-2-thumb.png", "124955183"],
      ["drtv-slendertone-thumb.png", "119589132"],
      ["drtv-mobile-help-thumb.png", "105769409"],
      ["drtv-education-connection-thumb.png", "79689795"],
      ["drtv-safe-step-thumb.png", "105769619"],
      ["drtv-flexshopper-host-thumb.png", "107081935"],
      ["drtv-hammerhead-thumb.png", "125151197"],
      ["drtv-goji-test-thumb.png", "111016628"],
      ["drtv-tboost-thumb.png", "69038520"],
      ["drtv-lawyers-dot-com-thumb.png", "59517089"],
      ["drtv-magic-tap-thumb.png", "48027830"],
      ["drtv-tx180-thumb.png", "105769620"],
      ["drtv-amp-booster-thumb.png", "79677873"],
      ["drtv-knife-saver-thumb.png", "48010358"],
      ["drtv-paw-power-thumb.png", "48026187"],
      ["drtv-lasaii-thumb.png", "61356596"],
      ["drtv-united-law-thumb.png", "106220311"]
    ]
  end

end
