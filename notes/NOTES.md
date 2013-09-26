# Random ideas

- Make Katuv have it's own DSL, to specify dsls. eg:

    katuv do
      nonterminal 'foo' do
        terminal 'bar'
        nonterminal 'baz', name: false
      end

      nonterminal baz do
        multiple 'quux'
        multiple 'qwix'
        nonterminal 'bang'
      end

      terminal 'quux'

      nonterminal 'qwix' do
        terminal 'rumplestiltskin'
      end

      nonterminal 'bang' do
        nonterminal 'bang', allow_blank: true
      end

    end

Which would build all the appropriate classes automatically for a DSL like:


    foo 'name' do
      bar 'name'
      baz do
        quux '1'
        quux '2'
        qwix do
          rumplestiltskin 'yep'
        end

        bang do
          bang do
            bang
          end
        end
      end
    end

- Bonus points if the above is self-hosting.
- More points if it can generate code or operate 'in-memory'
