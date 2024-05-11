# frozen_string_literal: true

module Admin
  class BlogPostsController < Admin::ApplicationController
    before_action :set_blog_post, except: %i[index new create]

    def index
      @blog_posts = @store.blog_posts
    end

    def show
    end

    def new
      @blog_post = BlogPost.new(store: @store)
    end

    def edit
      @store = nil # FIXME
    end

    def create
      @blog_post = BlogPost.new(create_params)
      if @blog_post.save
        respond_to do |format|
          format.html { redirect_to admin_blog_post_url(@blog_post) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @blog_post.update(update_params)
        respond_to do |format|
          format.html { redirect_to admin_blog_post_url(@blog_post) }
          format.turbo_stream
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @blog_post.destroy
        flash.notice = t('.success')
        redirect_to admin_store_blog_posts_url(@store)
      else
        flash.alert = t('.alert')
        redirect_to admin_blog_post_url(@blog_post)
      end
    end

    private

    def set_blog_post
      @blog_post = @store.blog_posts.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def create_params
      params.require(:blog_post).permit(:key).merge(store: @store, created_by: fingerprint, updated_by: fingerprint)
    end

    def update_params
      params.require(:blog_post).permit(:key).merge(store: @store, updated_by: fingerprint)
    end
  end
end
