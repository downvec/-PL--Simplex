function [Results] = benchmark(maxD)
	% Creando problema Klee-Minty para dims de 2 a maxD
	Results = [];	
	for d = 2:maxD
		R = vander(10 * ones(1, d));
		cs = R(d, :);
		r = fliplr(cs)';

		% Creando matriz de coeficientes Klee-Minty
		A = eye(d);
		for i = 1:d-1
			A = A + diag(2 * 10^i * ones(1, d-i), -i);
		end

		% Concatenando restricciones y costos
		A = [A, eye(d), r; -cs, zeros(1,d+1)];

		% Corriendo simplex sobre problema Klee-Minty
		fprintf("Aplicando simplex a Klee-Minty dim %d", d)
		[A, t, steps] = Simplexealo(A);

		Results = [Results; d, steps, t];
	end
end	
