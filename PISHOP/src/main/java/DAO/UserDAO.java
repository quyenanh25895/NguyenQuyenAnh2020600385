package DAO;

import DAO.IDAO.IUserDAO;
import Mapper.UserMapper;
import Model.UserModel;
import org.apache.commons.lang.StringUtils;
import paging.IPageble;

import java.util.List;

public class UserDAO extends AbstractDAO<UserModel> implements IUserDAO {

    @Override
    public List<UserModel> findAll(IPageble pageble) {
        StringBuilder sql = new StringBuilder("SELECT * FROM users AS u INNER JOIN roles AS r ON r.roleID = u.roleID");

        if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName()) && StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
            sql.append(" ORDER BY " + pageble.getSorter().getSortName() + " " + pageble.getSorter().getSortBy() + "");
        }
        if (pageble.getOffset() != null && pageble.getLimit() != null) {
            sql.append(" LIMIT " + pageble.getOffset() + ", " + pageble.getLimit() + "");
        }
        return query(sql.toString(), new UserMapper());
    }

    @Override
    public UserModel findByUserNameAndPasswordAndStatus(String userName, String password) {
        StringBuilder sql = new StringBuilder("SELECT * FROM users AS u");
        sql.append(" INNER JOIN roles AS r ON r.roleID = u.roleID");
        sql.append(" WHERE BINARY username = ? AND BINARY password = ?");
        List<UserModel> users = query(sql.toString(), new UserMapper(), userName, password);
        return users.isEmpty() ? null : users.get(0);
    }

    @Override
    public UserModel findByUserNameAndEmail(String userName, String email) {
        StringBuilder sql = new StringBuilder("SELECT * FROM users AS u");
        sql.append(" INNER JOIN roles AS r ON r.roleID = u.roleID");
        sql.append(" INNER JOIN forgots AS f ON u.userID = f.userID");
        sql.append(" WHERE BINARY u.username = ? AND BINARY u.email = ?");
        List<UserModel> users = query(sql.toString(), new UserMapper(), userName, email);
        return users.isEmpty() ? null : users.get(0);
    }

    @Override
    public UserModel findOne(int id) {
        String sql = "SELECT * FROM users WHERE userID = ?";
        List<UserModel> userModels = query(sql, new UserMapper(), id);
        if (userModels.isEmpty()) {
            return null;
        } else {
            return userModels.get(0);
        }
    }

    @Override
    public Integer save(UserModel saveUser) {
        StringBuilder sql = new StringBuilder("INSERT INTO users");
        sql.append("(userFullname, email, userPhonenumer, userAddress, userGender,");
        sql.append("username, password, roleID, status, createBy, createdDate)");
        sql.append(" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        return insert(sql.toString(), saveUser.getFullName(), saveUser.getEmail(), saveUser.getPhoneNumber(), saveUser.getAddress(),
                saveUser.getGender(), saveUser.getUserName(), saveUser.getPassword(), saveUser.getRoleId(), 1,
                saveUser.getCreatedBy(), saveUser.getCreatedDate());
    }

    @Override
    public void update(UserModel updateUser) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE users SET ");
        sql.append("userFullname = ?, email = ?, userPhonenumer = ?, userAddress = ?, userGender = ?,");
        sql.append("username = ?, password = ?, roleID = ?,createBy = ?, createdDate = ?, modifiedBy = ?, modifiedDate = ?, status = ? ");
        sql.append("WHERE userID = ?");

        update(sql.toString(), updateUser.getFullName(), updateUser.getEmail(),
                updateUser.getPhoneNumber(), updateUser.getAddress(),
                updateUser.getGender(), updateUser.getUserName(), updateUser.getPassword(), updateUser.getRoleId(),
                updateUser.getCreatedBy(), updateUser.getCreatedDate(), updateUser.getModifiedBy(),
                updateUser.getModifiedDate(), updateUser.getStatus(), updateUser.getId());
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM users WHERE userID = ?";
        delete(sql, id);
    }

    @Override
    public void disableUser(Integer id) {
        String sql = "UPDATE users SET status = 0 WHERE userID = ?";
        update(sql, id);
    }

    @Override
    public void enableUser(Integer id) {
        String sql = "UPDATE users SET status = 1 WHERE userID = ?";
        update(sql, id);
    }

    @Override
    public Integer countItem() {
        String sql = "SELECT count(*) from users";
        return count(sql);
    }

    @Override
    public boolean checkUserExist(String userName) {
        String sql = "SELECT * FROM users WHERE username = ?";
        List<UserModel> userModels = query(sql, new UserMapper(), userName);
        if (userModels.isEmpty()) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public Integer saveCode(UserModel user, String code) {
        String sql = "insert into forgots(userID, code) values(?, ?)";
        return insert(sql, user.getId(), code);
    }

    @Override
    public UserModel checkCode(String code) {
        StringBuilder sql = new StringBuilder("SELECT u.username, u.password, f.code, f.createdDate,");
        sql.append(" u.userID, u.userFullname, u.email, u.userPhonenumer, u.userAddress,");
        sql.append(" u.userGender, u.username, u.password, u.roleID, u.status, u.createBy, u.modifiedBy, u.modifiedDate");
        sql.append(" FROM users AS u");
        sql.append(" INNER JOIN roles AS r ON r.roleID = u.roleID");
        sql.append(" INNER JOIN forgots AS f ON u.userID = f.userID");
        sql.append(" WHERE f.code = ? AND f.createdDate >= NOW() - INTERVAL 5 MINUTE ");
        List<UserModel> users = query(sql.toString(), new UserMapper(), code);
        if (users.isEmpty()) {
            return null;
        } else {
            return users.get(0);
        }
    }

}

