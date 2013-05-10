class PagesController < ApplicationController
  def home
    render layout: false
  end

  def the_peculiar_institution
    @video_id = 'sIcGaamTFxk'

    @slides = Dir.entries('app/assets/images/slides/the_peculiar_institution')
    @slides.delete_if do |image|
      !image.include?('.jpg') &&
      !image.include?('.png') &&
      !image.include?('.gif')
    end
    @slides.map! { |slide| slide = "slides/the_peculiar_institution/#{slide}" }
  end

  def democracy_in_america
    @video_id = '48eoUKalprw'
  end

  def aggregation
    @video_id = '3lcqTp2A750'
  end
end
