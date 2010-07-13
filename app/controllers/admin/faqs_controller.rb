class Admin::FaqsController < AdminController
  before_filter :delete_caches, :except => [ :index, :new, :edit ]

  def index
    @faqs = Faq.paginate(:page => params[:page], :per_page => 15, :order => "position")
  end

  def destroy
    @faq = Faq.find(params[:id])
    @faq.destroy

    respond_to do |wants|
      wants.html { redirect_to admin_faqs_path }
      wants.js
    end
  end

  def new
    @meta_title = "New FAQ"
    @faq ||= Faq.new
  end
  
  def create
    @faq = Faq.new(params[:faq])
    if @faq.save
      flash[:notice] = "FAQ created."
      redirect_to admin_faqs_path
    else
      render :action => "new"
    end
  end

  def edit
    @meta_title = "Edit FAQ"
    @faq = Faq.find(params[:id])
  end

  def update
    @faq = Faq.find(params[:id])
    @faq.permalink = nil
    if @faq.update_attributes(params[:faq])
      flash[:notice] = "FAQ updated."
      redirect_to admin_faqs_path
    else
      render :action => "edit"
    end
  end

  def update_positions
    params["sortable_list"].each_with_index do |id, position|
      Faq.update(id, :position => position+1)
    end
    render :nothing => true
  end

  
  private
  
    def delete_caches
      Rails.cache.delete('Faq.cached_all')
    end

end
