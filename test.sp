mana $hp~

elixir $magic~

$hp => 100~

$magic => 25.5~

$magic => $hp + 3.2~

cast_if ($hp == 100)

begin_spell

    mana $hp~

    $hp => 50~

    elixir $power => 10~

    $power => $power + 5~

end_spell

cast_else

begin_spell

    mana $enemy~

    $enemy => 0~

end_spell

mana $hp~

$unknown => 10~

mana $x => 2.5~