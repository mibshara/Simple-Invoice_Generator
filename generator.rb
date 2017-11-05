

#Provided Data
orders_by_customer_id = {
  101 => [{ product_id: 13, quantity: 2  },
          { product_id: 35, quantity: 16 },
          { product_id: 11, quantity: 3  }],
  24  => [{ product_id: 11, quantity: 3  },
          { product_id: 35, quantity: 4  }],
  36  => [{ product_id: 25, quantity: 17 },
          { product_id: 42, quantity: 2  },
          { product_id: 35, quantity: 7  }]
}
products_by_id = {
  11 => { name: 'teddy bear', price: 14.23 },
  25 => { name: 'toy ghosts', price: 4.34  },
  13 => { name: 'giant newt', price: 56.00 },
  42 => { name: 'sandcastle', price: 12.45 },
  35 => { name: 'shoe phone', price: 86.00 }
}
customers_by_id = {
  101 => { name: 'John Smith',
           address: '128 Good St.',
           city: 'Winnipeg',
           province: 'MB' },
  24  => { name: 'Ralph Woodhorse',
           address: '67 Pylon Way',
           city: 'Calgary',
           province: 'AB' },
  36  => { name: 'Mary Contra',
           address: '342 Modem Drive',
           city: 'Regina',
           province: 'SK' }
}
SALES_TAX_BY_PROVINCE = { 'MB' => 0.08,
                          'AB' => 0,
                          'BC' => 0.07,
                          'SK' => 0.05 }.freeze # .freeze makes hash immutable
GST = 0.05
def currency(amount)
  format('$%.2f', amount)
end

#Test Code
#puts customers_by_id[101][:name]
#puts products_by_id[11][:price]
#puts orders_by_customer_id[36].size

# total_quantity = 0
# orders_by_customer_id[24].each do |item|
#    total_quantity += item[:quantity]
# end
# puts total_quantity

#looping through customers
customers_by_id.each do | customer_key, customer_details |

  #Declaring and resetting variables
  sub_total = 0
  province_tax = 0

  #printing each customer
  puts "\nInvoice for #{customer_details[:name]}"
  puts customer_details[:address]
  puts "#{customer_details[:city]}, #{customer_details[:province]}\n\n"

  #looping through orders ids
  orders_by_customer_id.each do | orders_key, order_details |

    #looping through orders details
    order_details.each do | key | if customer_key == orders_key

      #saving values
        product_id = key[:product_id]
        quantity = key[:quantity]

        #looping through products
        products_by_id.each do | product_key, products_details | if product_key == product_id

          #saving values
          product_name = products_details[:name]
          product_price = products_details[:price]
          total_price = quantity * product_price
          sub_total += total_price

          #tax calculation
          SALES_TAX_BY_PROVINCE.each do | province_key, tax | if customer_details[:province] == province_key
          province_tax = tax

          #printing product details
                      puts "#{product_name} ................. #{quantity} x #{currency(product_price)} = #{currency(total_price)}"
              end #tax loop
            end #province if
          end #product id checks
        end #product do loop
      end #customer key if
    end #details do lopp
  end #orders_by_customer_id do loop

  #totals
  total_pst = sub_total * province_tax
  total_gst = sub_total * GST
  grand_total = sub_total + total_gst + total_pst

  #printing totals
  puts "\nSub Total    : #{currency(sub_total)}"
    if province_tax > 0
      puts "PST (5.00%)  : #{currency(total_pst)}"
    end #tax check
  puts "GST (5.00%)  : #{currency(total_gst)}"
  puts "Grand Total  : #{currency(grand_total)}"

end #customers_by_id do loop
