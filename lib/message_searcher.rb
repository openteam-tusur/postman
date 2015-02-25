class MessageSearcher < Struct.new(:params)
  def page
    params[:page] || 1
  end

  def per_page
    @per_page ||= 10
  end

  def query
    params[:q] || nil
  end

  def results
    search.results
  end

  def search
    Message.search do |ms|
      ms.keywords query if query.present?
      ms.order_by(:created_at, :desc)
      ms.paginate(:page => page, :per_page => per_page)
    end
  end
end
