require_relative './part_1_solution.rb'
require 'pry'
def apply_coupons(cart, coupons)
  counter = 0
  while counter < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    discount_item_name = "#{coupons[counter][:item]} W/COUPON"
    items_with_coupon = find_item_by_name_in_collection(discount_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if items_with_coupon
        items_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        items_with_coupon = {
          :item => discount_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << items_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1
  end
  cart
end
#returns new_array = [{}]


def apply_clearance(cart)
  counter = 0
  while counter < cart.length
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2)
    end
      counter += 1
  end
  cart
end
# returns cart with 20% subtracted from items with :clearance value == true
# round price to 2 decimal places using .round!!

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  discounted_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(discounted_cart)

  total = 0
  counter = 0
  while counter < clearanced_cart.length
    total += clearanced_cart[counter][:price] * clearanced_cart[counter][:count]
    counter += 1
  end
  if total > 100
    total -= (total * 0.10)
  end
    total
end
#
