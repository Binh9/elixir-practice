defmodule Practice.Factor do
  def factor(x) do
    # Factoring the number 
    numbers = 1..x
    Enum.to_list(numbers)
    Enum.filter(numbers, fn(y) -> (rem x, y) ==  0 end)
  end 
end
