class ChaptersController < ApplicationController
  before_filter :signed_in!

  def show
    @lecture_chapter = CMS::LectureChapter.find(params[:id])
  end
end
