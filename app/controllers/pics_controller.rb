class PicsController < ApplicationController
    before_action :set_pic, only: [:show, :edit, :update, :destroy, :upvote]
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @pics = Pic.all.order(created_at: :desc)
    end

    def show
    end

    def new
        @pic = current_user.pics.build
    end

    def create
        @pic = current_user.pics.build(pic_params)

        if @pic.save
            redirect_to @pic, notice: 'Yesss! It was posted!'
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @pic.update(pic_params)
            redirect_to @pic, notice: 'Congrats! Pic was updated!'
        else
            render 'edit'
        end
    end

    def destroy
        if @pic.destroy
            redirect_to root_path, notice: 'It was destroyed!'
        else
            redirect_to @pic, notice: 'It not was destroyed!'
        end
    end

    def upvote
        @pic.upvote_by current_user
        redirect_to @pic
    end

    private
        def pic_params
            params.require(:pic).permit(:title, :description, :image)
        end

        def set_pic
            @pic = Pic.find(params[:id])
        end
end
