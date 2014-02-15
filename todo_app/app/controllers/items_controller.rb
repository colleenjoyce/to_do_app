class ItemsController < ApplicationController 

#     items GET    /items(.:format)          items#index
	def index 
		@items = Item.all

		respond_to do |format|
			# format.html 
			format.json { render json: @items }
		end
	end
#           POST   /items(.:format)          items#create
	def create
		@item = Item.create(item_params) 
		respond_to do |format|
			format.html { redirect_to items_path(@item) }			
			format.json {render json: @item}
		end
	end

#  new_item GET    /items/new(.:format)      items#new

# edit_item GET    /items/:id/edit(.:format) items#edit
#      item GET    /items/:id(.:format)      items#show
	def update
		@item = Item.find(params[:id])
		@item.update_attributes(item_params)

		respond_to do |format|
			format.json { render json: @item }
		end
	end

#           DELETE /items/:id(.:format)      items#destroy

	def destroy
		@item = Item.find(params[:id])
		@item.destroy
		respond_to do |format|
			format.json { render json: @item }
		end
	end 
 

#           PATCH  /items/:id(.:format)      items#update
	private 

	def item_params
		params.require(:item).permit(:task, :due_date)
	end

#           PUT    /items/:id(.:format)      items#update


end


