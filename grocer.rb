
def consolidate_cart(cart)
  # code here
  cart.each_with_object({}) do |product, details|
    product.each do |type, attributes|
      if details[type]
        attributes[:count] += 1
      else
        attributes[:count] = 1
        details[type] = attributes
      end
    end
  end
end

def apply_coupons(cart, coupons)
  # code here
  puts cart
  puts coupons

  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"] # if coupon already exists, add to count
        cart["#{name} W/COUPON"][:count] += 1
      else # else, create a line in the hash for coupon
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart

end

def apply_clearance(cart)
  # code here

  cart.each do |name, details|
    if details[:clearance]
      updated_price = details[:price] * 0.80
      details[:price] = updated_price.round(2)
    end
  end
  cart
end


def checkout(cart, coupons)
  # code here

  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  final = apply_clearance(coupon_cart)
  total_cost = 0
  final.each do |name, details|
    total_cost += details[:price] * details[:count]
  end

  if total_cost > 100
    total_cost = total_cost * 0.9
  end

  total_cost
end
