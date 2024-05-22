package Filter;

import Constants.SystemConstant;
import Model.UserModel;
import Utils.MessageUtil;
import Utils.SessionUtil;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AuthorizationFilter implements Filter {
    private ServletContext context;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.context = filterConfig.getServletContext();
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        String url = req.getRequestURI();

        if (url.contains("/admin")) {
            UserModel model = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
            if (model != null) {
                if (model.getRoleName().equals(SystemConstant.ADMIN)) {
                    filterChain.doFilter(servletRequest, servletResponse);
                } else if (model.getRoleName().equals(SystemConstant.USER)) {
                    resp.sendRedirect(req.getContextPath() + "/login?action=login&message=not_permission&alert=danger");
                    SessionUtil.getInstance().removeValue(req, "USERMODEL");
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/login?action=login&message=not_login&alert=danger");
            }
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }

    }

    @Override
    public void destroy() {

    }
}
