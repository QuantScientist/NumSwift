import Accelerate

public func pow(x: [Float], power: Float) -> [Float] {

    /*
    Raise each element in x to higher power.

    input:
        `x`: An array of floating numbers.
        `power`: the power to raise the elements in `x` to.
    return:
        `y`: An array of floating numbers with its i-th element be raised to
             the `power`-th power of x[i].
    */

    var y = [Float](count: x.count, repeatedValue: 0.0)
    let powers = [Float](count: x.count, repeatedValue: power)
    var N = Int32(x.count)

    vvpowf(&y, x, powers, &N)
    return y
}

public func pow(x:[Double], power: Double) -> [Double] {

    /*
    Raise each element in x to higher power.

    input:
        `x`: An array of double-precision floating numbers.
        `power`: the power to raise the elements in `x` to.
    return:
        `y`: An array of double-precision floating numbers with its i-th element
             be raised to the `power`-th power of x[i].
    */

    var y = [Double](count: x.count, repeatedValue: 0.0)
    let powers = [Double](count: x.count, repeatedValue: power)
    var N = Int32(x.count)

    vvpow(&y, x, powers, &N)
    return y
}

public func sqrt(x:[Double]) -> [Double] {

    var input = [Double](x)
    var output = [Double](count:x.count, repeatedValue:0.0)
    var N = Int32(x.count)
    vvsqrt(&output, &input, &N)

    return output

}

public func sqrt(x:[Float]) -> [Float] {

    var input = [Float](x)
    var output = [Float](count:x.count, repeatedValue:0.0)
    var N = Int32(x.count)
    vvsqrtf(&output, &input, &N)

    return output

}
