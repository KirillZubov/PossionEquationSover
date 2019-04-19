using Plots
#solver for Poision eqution y" + x" = f(x,y,t)
function PDEsolver(f, x_init, x_end, N, y0, x0, yn, xn )
    N2 = N^2
    dx = (x_end - x_init) / N
    dx2 = (x_end - x_init) / N2
    x = x_init : dx2 : x_end -dx2
    y = x
    xc = x_init : dx : x_end - dx
    yc = xc
    B = zeros(N2)
    A = zeros(N2, N2)
    for i in 1:N , j in 1:N
        B[(i-1)*N+j] = f(xc[i], yc[j])
    end

    for i in 1:N2 , j in 1:N2
        if i == 1
            A[i, j] = x0
        end
        if j == 1
            A[i, j] = y0
        end
        if i == N
            A[i, j] = 0
        end
        if j == N
            A[i, j] = 0
        end
        abs(i-j) <= 1 && (A[i,j] = 1)
        i == j && (A[i,j] = -4)
    end
    A = A / dx2
    U  = A\B
    Un = reshape(U, (N, N))
    xc = x_init : dx : x_end - dx
    yc = xc
    return (xc, yc, Un)
end


f(x,y) = x^2 + y^2
solve = PDEsolver(f, -1, 1, 50, 0, 0, 0, 0)
plot(solve, st=:surface)
