//
//  MakeTImeTables.swift
//  HYU_TT
//
//  Created by 김영호 on 2017. 6. 1..
//  Copyright © 2017년 김나용. All rights reserved.
//

import Foundation

func MakeTimeTables()->[[Int]] {
    var graph:[[Int]] = MakeGraph()
    var temp = ChoosenSub.subjects
    var R:[Int] = []
    var P:[Int] = []
    var X:[Int] = []
    
    for i in 0..<graph.count {
        P.append(i)
    }
    var stack:[[Int]] = []
    var tmp = BronKerbosch(R: R, P: &P , X: X, g: graph, stack: &stack)
    if (tmp.count != 0 && tmp.count != 1) {
        stack.append(tmp)
    }
    return stack
}


extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

func MakeGraph()->[[Int]] {
    var graph:[[Int]] = []
    
    for firstIndex in 0..<ChoosenSub.subjects.count {
        graph.append([])
        for secondIndex in 0..<firstIndex {
            if (IsSubjectIntersect(subject1: ChoosenSub.subjects[firstIndex], subject2: ChoosenSub.subjects[secondIndex]) == false ) {
                graph[firstIndex].append(secondIndex)
                graph[secondIndex].append(firstIndex)
            }
        }
    }
    
    return graph
}

func IsSubjectIntersect(subject1:Subject, subject2:Subject)->Bool {
    if (subject1.number == subject2.number) { return true }
    for time1 in subject1.time {
        for time2 in subject2.time {
            if (time1.substring(with: 0..<1) == time2.substring(with: 0..<1)) {
                let time1_start = time1.substring(with: 2..<7)
                let time1_end = time1.substring(with: 8..<13)
                let time2_start = time2.substring(with: 2..<7)
                let time2_end = time2.substring(with: 8..<13)
                if (time2_start < time1_start && time1_start < time2_start // time1의 시작시간이 time2 강의시간 사이에 있을 경우
                    || time2_start < time1_end && time1_end < time2_end || // time1의 끝나는 시간이 time2 강의시간 사이에 있을 경우
                    time1_start == time2_start && time1_end == time2_end) { // 둘의 강의 시간이 같을 경우
                    return true;
                }
            }
        }
    }
    return false;
}



//합집합 구하기
func UnionSet(A:[Int], B:[Int])->[Int] {
    let Set_A = Set(A)
    let Set_B = Set(B)
    return Array(Set_A.union(Set_B))
    
}

//교집합 구하기
func IntersectSet(A:[Int], B:[Int])->[Int] {
    let Set_A = Set(A)
    let Set_B = Set(B)
    return Array(Set_A.intersection(Set_B))
}

//A안에 B가 포함되어있는지 확인
func isBIncludedInA(A:[Int], B:[Int])->Bool {
    var numOfSameComponet:Int = 0
    for i in 0..<A.count {
        for j in 0..<B.count {
            if (A[i] == B[j]) { numOfSameComponet += 1 }
        }
    }
    if (numOfSameComponet == B.count) { return true }
    else { return false }
}

func SpliceArray(index:Int, howMany:Int, array:[Int])->[Int] {
    var result = array
    for _ in 0..<howMany {
        result.remove(at: index)
    }
    return result
}

func BronKerbosch(R:[Int], P:inout [Int], X:[Int], g:[[Int]], stack:inout [[Int]]) -> [Int] {
    if (P.count == 0 && X.count == 0) {
        return R
    }
    var tmp:[Int] = []
    while (P.count != 0) {
        var R_tmp:[Int] = []
        var P_tmp:[Int] = []
        var X_tmp:[Int] = []
        var result:[Int] = []
        var N:[Int] = []
        for i in 0..<g[P[0]].count {
            N.append(g[P[0]][i]);
        }
        tmp.append(P[0]);
        R_tmp = UnionSet(A:R, B:tmp);
        P_tmp = IntersectSet(A:P, B:N);
        X_tmp = IntersectSet(A:X, B:N);
        result = BronKerbosch(R:R_tmp, P:&P_tmp, X:X_tmp, g:g, stack:&stack);
        if (result.count != 0 && result.count != 1) {
            
            var indexOfForLoop:Int = 0
            for j in 0..<stack.count {
                if (isBIncludedInA(A: stack[j], B: result)) { break }
                else if (isBIncludedInA(A: result, B: stack[j])) {
                    stack[j] = result
                }
                indexOfForLoop += 1
                
            }
            if (indexOfForLoop == stack.count) { stack.append(result) }
        }
        
        P = SpliceArray(index: 0, howMany: 1, array: P)
        tmp = SpliceArray(index: 0, howMany: tmp.count, array: tmp)//tmp.splice(0, tmp.length);
    }
    return tmp;
}
