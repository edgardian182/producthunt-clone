module ProductsHelper
  def form_title
    @product.new_record? ? "Publicar Product" : "Modificar Producto"
  end

end