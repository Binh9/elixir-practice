defmodule Practice.Factor do
  def factor(x) do 
    factHelper(x, 2, [])
  end

  defp factHelper(x, d, acc) when d <= x do
    if (rem(x, d) == 0) do
        factHelper(div(x, d), 2, acc ++ [d])
    else
        factHelper(x, d+1, acc)
    end
  end

  defp factHelper(x, d, acc) when d > x do
    acc
  end
end
