# frozen_string_literal: true

module Admin
  class BlogPostTranslationsController < Admin::ApplicationController
    before_action :set_blog_post, only: %i[new create]
    before_action :set_blog_post_translation, except: %i[new create]

    def show
      @content = @blog_post_translation.blog_post.markdown_content
    end

    def new
      @blog_post_translation = BlogPostTranslation.new(blog_post: @blog_post, store: @store)
    end

    def edit
      @blog_post = nil
    end

    def create
      @blog_post_translation = BlogPostTranslation.new(create_params)
      if @blog_post_translation.save
        respond_to do |format|
          format.html { redirect_to admin_blog_post_url(@blog_post) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @blog_post = nil
      if @blog_post_translation.update(update_params)
        respond_to do |format|
          format.html { redirect_to admin_blog_post_url(@blog_post_translation.blog_post) }
          format.turbo_stream
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @blog_post_translation.destroy
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_blog_post_url(@blog_post)
    end

    private

    def set_blog_post
      @blog_post = @store.blog_posts.find(params[:blog_post_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_blog_post_translation
      @blog_post_translation = @store.blog_post_translations.find(params[:id])
      @blog_post = @blog_post_translation.blog_post
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def create_params
      params.require(:blog_post_translation).permit(
        :title, :content, :locale
      ).merge(
        blog_post: @blog_post, store: @store, created_by: fingerprint, updated_by: fingerprint
      )
    end

    def update_params
      params.require(:blog_post_translation).permit(
        :title, :content, :locale
      ).merge(
        updated_by: fingerprint
      )
    end
  end
end
