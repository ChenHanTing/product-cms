module Client::ProductsHelper
  def cover(product)
    default_cover = 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=80'

    image_tag product&.pics&.first || default_cover
  end
end
