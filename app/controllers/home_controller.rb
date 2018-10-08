# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @latest_posts = Post.latest_posts(4)
  end
end
