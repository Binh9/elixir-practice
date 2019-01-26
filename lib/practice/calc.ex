defmodule Practice.Calc do
  # Parse string into the float 
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  # Translates the given element into tuple with first element indicating the type
  # of the given element (i.e. op for operator, and num for number)
  # String --> tuple 
  def tokenize(el) do
    if Enum.member?(["+", "-", "*", "/"], el) do
        {:op, el}
    else
        {:num, Practice.Calc.parse_float(el)}
    end
  end


  # Tokenizes the elements in the given list of strings
  # ListOfString --> ListOfTuple
  def tag_tokens(los) do
    Enum.map(los, &Practice.Calc.tokenize/1)
  end


  # Using pattern matching evaluate the expression (1 operand)
  # ListOfTuple (size 3) --> ListOfTuple (size 1) 
  
  # Multiplication 
  def eval([{:num, a}, {:op, "*"}, {:num, b}]) do
    [{:num, a*b}]
  end

  # Division
  def eval([{:num, a}, {:op, "/"}, {:num, b}]) do
    if (b == 0) do 
        throw("Division by 0? Really?")
    else
        [{:num, a/b}]
    end
  end

  # Addition
  def eval([{:num, a}, {:op, "+"}, {:num, b}]) do
    [{:num, a+b}]
  end

  # Subtraction 
  def eval([{:num, a}, {:op, "-"}, {:num, b}]) do
    [{:num, a-b}]
  end
  
  # Performs the multiplications and divisions in the expression
  # ListOfTuple --> ListOfTuple (with only addition and subtraction)
  def mult_div([head | rest], acc) do
    cond do
        length(rest) == 0 ->
            Practice.Calc.add_sub(acc ++[head])

        Enum.member?(["*", "/"], elem(Enum.at(rest, 0), 1)) ->
            operand_1 = head
            operand_2 = Enum.at(rest, 1)
            operator = Enum.at(rest, 0)

            mult_div(eval([operand_1, operator, operand_2]) ++ tl(tl(rest)), acc)

        length(rest) > 0 ->
            mult_div(rest, acc ++ [head])
        
        true ->
            throw("Something broke evaluating * and /")
    end
  end

  # Performs the additions and subtractions in the expression
  # ListOfTuple --> Number
  def add_sub([head | rest]) do
    cond do 
        length(rest) == 0 ->
            elem(head, 1)

        length([head | rest]) >= 3 ->
            add_sub(eval([head, Enum.at(rest, 0), Enum.at(rest, 1)]) ++ tl(tl(rest)))

        true ->
            throw("Something went wrong when doing + and -")
    end
  end

        
  # Main function to call
  def calc(expr) do
    lot = expr |> String.split(~r/\s+/) |> tag_tokens
    mult_div(lot, [])
  end
end
