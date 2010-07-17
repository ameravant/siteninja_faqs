class FaqsController < ApplicationController
  unloadable
  def index
    add_breadcrumb "Home", "/"
    add_breadcrumb "FAQs"
    @meta_title = "Frequently Asked Questions"
    if params[:q].blank?
      @faqs_all = Faq.cached_all
    else
      @faqs_all = Faq.find(:all, :order => "position", :conditions => ["question like ?", "%#{params[:q].strip}%"])
    end
    @faqs = @faqs_all.paginate(:page => params[:page], :per_page => 20)
    @tags = Faq.tag_counts
  end
  
  def show
    add_breadcrumb "Home", "/"
    add_breadcrumb "FAQs", faqs_path
    @faq = Faq.find_by_permalink(params[:id])
    add_breadcrumb @faq.question
    @related_faqs = Faq.find_tagged_with(@faq.tag_list)
    @faqs = Faq.find(:all, :limit => 5, :conditions => ["id not in (?)", @related_faqs.collect(&:id)])
    @related_faqs.reject! { |x| x.id == @faq.id } # reject shown faq    
    @meta_title = @faq.question
    @tags = Faq.tag_counts
  end
  
  def tag
    @tag = params[:id].strip.downcase
    add_breadcrumb "Home", "/"
    add_breadcrumb "FAQs", faqs_path
    add_breadcrumb "#{@tag.titleize} FAQs"
    tagged_faqs = Faq.find_tagged_with(@tag).sort_by(&:question)
    @faqs = tagged_faqs.paginate(:page => params[:page], :per_page => 30)
    @tags = Faq.tag_counts
    @meta_title = "#{@tag.titleize} FAQs"
  end
  
end
