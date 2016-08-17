class AdminAssetsController < ApplicationController
	def index
		@admin_assets = Asset.all
	end
	def show
		@admin_asset = Asset.find(params[:id])
	end
	def new
		@admin_asset = Asset.new

	end
	def edit
		@admin_asset = Asset.find(params[:id])
	end
	def create
		ac= AssetCategory.where(asset_category: params[:asset][:asset_category], asset_type: params[:asset][:asset_type]).first
		l_asset= Asset.where(asset_category: params[:asset][:asset_category], asset_type: params[:asset][:asset_type]).last
		if ac.nil?
			cat = AssetCategory.where(asset_category: params[:asset][:asset_category]).first
			new_a_c= AssetCategory.new
			new_a_c.asset_category = params[:asset][:asset_category]
			new_a_c.asset_type= params[:asset][:asset_type]
			new_a_c.type_id =  1

			
			if cat.nil?
				last_cat=AssetCategory.order("category_id").last

				if last_cat.nil?
					new_a_c.category_id=1
				else

					new_a_c.category_id=(last_cat.category_id+1)
				end
			else

				new_a_c.category_id=cat.category_id
			end
			new_a_c.asset_category_id= (new_a_c.category_id*10) + new_a_c.type_id
			new_a_c.save
			ac_id=new_a_c.asset_category_id
			
		else 
			ac_id=ac.asset_category_id
		end
		
		if l_asset.nil? 
			
			calc = ac_id.to_i*1000
			
		else
			calc= l_asset.asset_id
		end
		calc=calc.to_i+1

		@admin_asset = Asset.new(params.require('asset').permit(:name, :asset_type, :asset_category, :specification, :assigned_to))
		@admin_asset.assigned_to = 0
		@admin_asset.asset_id= calc
		if @admin_asset.save
			
			redirect_to admin_asset_path(@admin_asset)
		else
			
			render 'new'
		end
	end
	def update
		@admin_asset = Asset.find(params[:id])
		if @admin_asset.update(params.require('asset').permit(:name, :asset_type, :asset_category, :specification, :assigned_to))
			redirect_to admin_asset_path(@admin_asset)
		else
			render 'edit'
		end
	end
	def destroy
		@admin_asset = Asset.find(params[:id])
		@admin_asset.destroy
		redirect_to admin_assets_path
	end
end
