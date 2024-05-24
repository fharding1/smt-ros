(declare-const p (_ BitVec 32))
(assert (= p #x00001feb))

(declare-const fnvp (_ BitVec 32))
(assert (= fnvp #x01000193))

(declare-const fnvo (_ BitVec 32))
(assert (= fnvo #x811c9dc5))

(declare-fun fnvstep ((_ BitVec 32) (_ BitVec 8)) (_ BitVec 32))

(assert (forall ((a (_ BitVec 32)) (b (_ BitVec 8))) (= (fnvstep a b) (bvmul (bvxor a ((_ zero_extend 24) b)) fnvp))))

(declare-fun H ((_ BitVec 32) (_ BitVec 32)) (_ BitVec 32))

(assert (forall ((a (_ BitVec 32)) (b (_ BitVec 32))) (= (H a b)
    (bvurem
            (fnvstep
             (fnvstep
                (fnvstep
		  (fnvstep fnvo ((_ extract 7 0) a))
		  ((_ extract 15 8) a))
		((_ extract 7 0) b))
	      ((_ extract 15 8) b))
      p))))

;(declare-const l0 (_ BitVec 64))
;(assert (= l0 #x00000000000082e1))

;(declare-const l1 (_ BitVec 64))
;(assert (= l1 #x00000000000042d7))

;(declare-const l2 (_ BitVec 64))
;(assert (= l2 #x000000000000e873))

;(declare-fun H ((_ BitVec 32) (_ BitVec 32)) (_ BitVec 32))

;(assert (forall ((a (_ BitVec 32)) (b (_ BitVec 32))) (= (H a b) ((_ extract 31 0) (bvurem (bvadd l0 (bvmul ((_ zero_extend 32) a) l1) (bvmul ((_ zero_extend 32) b) l2)) ((_ zero_extend 32) p))))))

(declare-const rho11 (_ BitVec 32))
(assert (bvult rho11 p))
(declare-const rho12 (_ BitVec 32))
(assert (bvult rho12 p))
(declare-const rho21 (_ BitVec 32))
(assert (bvult rho21 p))
(declare-const rho22 (_ BitVec 32))
(assert (bvult rho22 p))
(declare-const rho31 (_ BitVec 32))
(assert (bvult rho31 p))
(declare-const rho32 (_ BitVec 32))
(assert (bvult rho32 p))

(declare-const c1 (_ BitVec 32))
(assert (bvult c1 p))
(declare-const c2 (_ BitVec 32))
(assert (bvult c2 p))

(assert (= ((_ extract 31 0) (bvurem (bvadd ((_ zero_extend 32) (bvmul c1 rho11)) ((_ zero_extend 32) (bvmul c2 rho12)) ) ((_ zero_extend 32) p))) (H rho11 rho12)))
(assert (= ((_ extract 31 0) (bvurem (bvadd ((_ zero_extend 32) (bvmul c1 rho21)) ((_ zero_extend 32) (bvmul c2 rho22)) ) ((_ zero_extend 32) p))) (H rho21 rho22)))
(assert (= ((_ extract 31 0) (bvurem (bvadd ((_ zero_extend 32) (bvmul c1 rho31)) ((_ zero_extend 32) (bvmul c2 rho32)) ) ((_ zero_extend 32) p))) (H rho31 rho32)))

(check-sat)
(get-value (rho11 rho12 rho21 rho22 rho31 rho32 c1 c2 (H rho11 rho12) (H rho21 rho22) (H rho31 rho32)))
