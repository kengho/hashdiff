## Summary

HashDiffSym is a fork of [HashDiff](https://github.com/liufengyun/hashdiff) (by [liufengyun](https://github.com/liufengyun)) with symbols support.

```
diff = HashDiffSym.diff({ 'a' => { x: 2, y: 3, z: 4 }, 'b' => { x: 3, z: [1, 2, 3] } },
                        { 'a' => { y: 3 },             'b' => { y: 3, z: [2, 3, 4] } })
diff.should == [['-', 'a.:x', 2], ['-', 'a.:z', 4], ['-', 'b.:x', 3], ["-", "b.:z[0]", 1], ["+", "b.:z[2]", 4], ['+', 'b.:y', 3]]
```

Also works for patch:

```
a = {a: 3}
b = {a: {a1: 1, a2: 2}}
diff = HashDiffSym.diff(a, b)
HashDiffSym.patch!(a, diff).should == b
```

## Installing

Add this to your Gemfile

`gem "hashdiff_sym"`

or just run

`gem install hashdiff_sym`

## License

HashDiffSym is distributed under the MIT-LICENSE.
