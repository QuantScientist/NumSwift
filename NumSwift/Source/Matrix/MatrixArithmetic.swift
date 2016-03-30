import Accelerate
import Foundation

public func mul(matA:[Float], _ matB:[Float], _ m:Int32, _ n:Int32, _ k:Int32) -> [Float]{
    
    let ptrMatA = UnsafeMutablePointer<Float>(matA)
    let ptrMatB = UnsafeMutablePointer<Float>(matB)
    var result = [Float](count:Int(m*n), repeatedValue:0)
    
    cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1, ptrMatA, k, ptrMatB, n, 1, &result, n)
    
    return result
}

public func mul(matA:[Double], _ matB:[Double], _ m:Int32, _ n:Int32, _ k:Int32) -> [Double]{
    
    let ptrMatA = UnsafeMutablePointer<Double>(matA)
    let ptrMatB = UnsafeMutablePointer<Double>(matB)
    var result = [Double](count:Int(m*n), repeatedValue:0)
    
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1, ptrMatA, k, ptrMatB, n, 1, &result, n)
    
    return result
}

public func mul(matA:[Double], _ matB:[Double]) throws -> [Double] {
    
    if matA.count != matB.count {
        throw MatrixError.LengthError
    }

    let ptrMatA = UnsafePointer<Double>(matA)
    let ptrMatB = UnsafePointer<Double>(matB)
    var result = [Double](count:matA.count, repeatedValue:0)

    vDSP_vmulD(ptrMatA, 1, ptrMatB, 1, &result, 1, UInt(matA.count))

    return result
}

public func mul(matA:[Float], _ matB:[Float]) throws -> [Float] {

    if matA.count != matB.count {
        throw MatrixError.LengthError
    }

    let ptrMatA = UnsafePointer<Float>(matA)
    let ptrMatB = UnsafePointer<Float>(matB)
    var result = [Float](count:matA.count, repeatedValue:0)

    vDSP_vmul(ptrMatA, 1, ptrMatB, 1, &result, 1, UInt(matA.count))

    return result
}

public func sub(matA:[Float], _ matB:[Float]) throws -> [Float] {
    
    if matA.count != matB.count {
        throw MatrixError.LengthError
    }
    
    let ptrMatA = UnsafeMutablePointer<Float>(matA)
    let ptrMatB = UnsafeMutablePointer<Float>(matB)
    var result = [Float](count:matA.count, repeatedValue:0)
    var one:Float = 1
    
    vDSP_vsmsb(ptrMatA, 1, &one, ptrMatB, 1, &result, 1, UInt(matA.count))
    
    return result
}

public func sub(matA:[Double], _ matB:[Double]) throws -> [Double]{
    
    if matA.count != matB.count {
        throw MatrixError.LengthError
    }
    
    let ptrMatA = UnsafeMutablePointer<Double>(matA)
    let ptrMatB = UnsafeMutablePointer<Double>(matB)
    var result = [Double](count:matA.count, repeatedValue:0)
    var one:Double = 1
    
    vDSP_vsmsbD(ptrMatA, 1, &one, ptrMatB, 1, &result, 1, UInt(matA.count))
    
    return result
}

public func sub(mat:[Double], _ scalar:Double) -> [Double] {
    
    let ptrMat = UnsafePointer<Double>(mat)
    var minusScalar:Double = -1*scalar
    var result = [Double](count:mat.count, repeatedValue:0)
    
    vDSP_vsaddD(ptrMat, 1, &minusScalar, &result, 1, UInt(mat.count))
    
    return result
}

public func sub(mat:[Float], _ scalar:Float) -> [Float] {
    
    let ptrMat = UnsafePointer<Float>(mat)
    var minusScalar:Float = -1*scalar
    var result = [Float](count:mat.count, repeatedValue:0)
    
    vDSP_vsadd(ptrMat, 1, &minusScalar, &result, 1, UInt(mat.count))
        
    return result
}

public func add(matA:[Float], _ matB:[Float]) throws -> [Float]{
    
    if matA.count != matB.count {
        throw MatrixError.LengthError
    }
    
    let ptrMatA = UnsafeMutablePointer<Float>(matA)
    let ptrMatB = UnsafeMutablePointer<Float>(matB)
    var result = [Float](count: matA.count, repeatedValue:0)
    
    vDSP_vadd(ptrMatA, 1, ptrMatB, 1, &result, 1, UInt(matA.count))
    
    return result
}

public func add(matA:[Double], _ matB:[Double]) throws -> [Double]{
    
    if matA.count != matB.count {
        throw MatrixError.LengthError
    }
    
    let ptrMatA = UnsafeMutablePointer<Double>(matA)
    let ptrMatB = UnsafeMutablePointer<Double>(matB)
    var result = [Double](count: matA.count, repeatedValue:0)
    
    vDSP_vaddD(ptrMatA, 1, ptrMatB, 1, &result, 1, UInt(matA.count))
    
    return result
}

public func add(mat:[Double], _ scalar:Double) -> [Double]{
    
    let ptrMat = UnsafePointer<Double>(mat)
    var scalar:Double = scalar
    var result = [Double](count:mat.count, repeatedValue:0)
    
    vDSP_vsaddD(ptrMat, 1, &scalar, &result, 1, UInt(mat.count))
    
    return result
}

public func add(mat:[Float], _ scalar:Float) -> [Float] {
    let ptrMat = UnsafePointer<Float>(mat)
    var scalar = scalar
    var result = [Float](count:mat.count, repeatedValue:0)
    
    vDSP_vsadd(ptrMat, 1, &scalar, &result, 1, UInt(mat.count))
    
    return result
}