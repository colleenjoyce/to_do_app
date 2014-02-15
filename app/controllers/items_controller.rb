class ItemsController < ApplicationController 

	def index 
		@items = Item.all

		respond_to do |format|
			format.json { render json: @items }
		end
	end

	def create
		@item = Item.create(item_params) 
		respond_to do |format|
			format.html { redirect_to items_path(@item) }			
			format.json {render json: @item}
		end
	end

	def update
		@item = Item.find(params[:id])
		@item.update_attributes(item_params)

		respond_to do |format|
			format.json { render json: @item }
		end
	end

	def destroy
		@item = Item.find(params[:id])
		@item.destroy
		respond_to do |format|
			format.json { render json: @item }
		end
	end 
 
	private 

	def item_params
		params.require(:item).permit(:task, :due_date)
	end
	
end


