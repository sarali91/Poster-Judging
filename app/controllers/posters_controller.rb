class PostersController < ApplicationController
    
    #render the view for judging each poster
    def judge
        @poster = Poster.find(params[:poster_id])
        @judge = Judge.find(params[:judge_id])
    end    
    
    #update the Score associated with a specific poster and a specific judge
    def update
        #check to make sure all radio buttons are checked

        flash[:notice] = "Unchecked"

        @score = Score.where(judge_id: params[:judge_id], poster_id: params[:id]).first()
        
        @score.update_attributes(:novelty => params[:novelty], :utility => params[:utility], :difficulty => params[:difficulty], :verbal => params[:verbal], :written => params[:written], :no_show => false)

        redirect_to judge_path(params[:judge_id])
    end

    def no_show
        @score = Score.where(judge_id: @judge.id, poster_id: @poster.id).first()

        @score.update_attributes(:no_show => true)

    end
end
