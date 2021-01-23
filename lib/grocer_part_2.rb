require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  cart.each do |item|
    coupons.each do |coupon|
    
      if item[:item] == coupon[:item]
        if item[:count] >= coupon[:num]
          
            item[:count] -= coupon[:num]
            
        cart << {
          :item => item[:item] + " W/COUPON",
          :price => coupon[:cost] / coupon[:num],
          :clearance => item[:clearance],
          :count => coupon[:num]
        }
      end 
      end 
    end 
  end 
  cart
end 



def apply_clearance(cart)

  cart.map do |item_index|
    if item_index[:clearance] == true
      item_index[:price] -= (item_index[:price] * 0.20)
    end 
  end 
  cart
end

def checkout(cart, coupons)
  c_cart = consolidate_cart(cart)
  coupon_applied_cart = apply_coupons(c_cart, coupons)

  last_cart = apply_clearance(coupon_applied_cart)

  
  total = 0 
  last_cart.each do |item|
    total += item[:price] * item[:count]
  end 
  if total > 100 
    total -= (total * 0.10)
  end 
  total 
end


