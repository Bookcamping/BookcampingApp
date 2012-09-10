# LibrariesController
class LibrariesController < ApplicationController
  expose(:library) { Library.find(params[:id]) }
end
